defmodule Hw07Web.EventController do
  use Hw07Web, :controller

  alias Hw07.Events
  alias Hw07.Events.Event

  alias Hw07Web.Plugs
  plug Plugs.RequireUser when action
    not in [:index, :show]
  plug :fetch_post when action
    in [:show, :photo, :edit, :update, :delete]
  plug :require_owner when action
    in [:edit, :update, :delete]

  def fetch_post(conn, _args) do
    id = conn.params["id"]
    event = Events.get_event!(id)
    assign(conn, :event, event)
  end

  def require_owner(conn, _args) do
    user = conn.assigns[:current_user]
    event = conn.assigns[:event]

    if user.id == event.user_id do
      conn
    else
      conn
      |> put_flash(:error, "You don't own that!!!")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end

  def index(conn, _params) do
    events = Events.list_events()
    render(conn, "index.html", events: events)
  end

  def new(conn, _params) do
    changeset = Events.change_event(%Event{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"event" => event_params}) do
    event_params = event_params
    |> Map.put("user_id", conn.assigns[:current_user].id)
    case Events.create_event(event_params) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "Event created successfully.")
        |> redirect(to: Routes.event_path(conn, :show, event))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    event = conn.assigns[:event]
    |> Events.load_comments()
    |> Events.load_invites()
    comm = %Hw07.Comments.Comment{
      event_id: event.id,
      user_id: current_user_id(conn),
    }
    inn = %Hw07.Invites.Invite{
      event_id: event.id,
    }
    new_comment = Hw07.Comments.change_comment(comm)
    new_invite = Hw07.Invites.change_invite(inn)
    render(conn, "show.html", event: event, new_comment: new_comment, new_invite: new_invite)
  end

  def edit(conn, %{"id" => id}) do
    event = conn.assigns[:event]
    changeset = Events.change_event(event)
    render(conn, "edit.html", event: event, changeset: changeset)
  end

  def update(conn, %{"id" => id, "event" => event_params}) do
    event = Events.get_event!(id)

    case Events.update_event(event, event_params) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "Event updated successfully.")
        |> redirect(to: Routes.event_path(conn, :show, event))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", event: event, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    event = conn.assigns[:event]
    {:ok, _event} = Events.delete_event(event)

    conn
    |> put_flash(:info, "Event deleted successfully.")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
