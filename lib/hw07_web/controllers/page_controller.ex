defmodule Hw07Web.PageController do
  use Hw07Web, :controller

  alias Hw07.Events

  def index(conn, _params) do
    events = Events.list_events()
    render(conn, "index.html", events: events)
  end
end
