defmodule Hw07Web.UserController do
  use Hw07Web, :controller

  alias Hw07.Users
  alias Hw07.Users.User
  alias Hw07.Photos
  alias Hw07Web.SessionController

  alias Hw07Web.Plugs
  plug Plugs.RequireUser when action
    not in [:index, :show, :new, :create, :prof_pic_hash]

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Users.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    up = user_params["prof_pic_hash"]
    {:ok, hash} = Photos.save_photo(up.filename, up.path)
    user_params = user_params
    |> Map.put("prof_pic_hash", hash)
    case Users.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: Routes.page_path(conn, :index))
        |> SessionController.create(user_params)


      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset)
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def prof_pic_hash(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    {:ok, _name, data} = Photos.load_photo(user.prof_pic_hash)
    conn
    |> put_resp_content_type("image/jpeg")
    |> send_resp(200, data)
  end

  def edit(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    changeset = Users.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)
    up = user_params["prof_pic_hash"]

    user_params = if up do
      {:ok, hash} = Photos.save_photo(up.filename, up.path)
      Map.put(user_params, "prof_pic_hash", hash)
    else
      user_params
    end

    case Users.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    {:ok, _user} = Users.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
