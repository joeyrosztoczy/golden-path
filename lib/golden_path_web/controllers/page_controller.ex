defmodule GoldenPathWeb.PageController do
  use GoldenPathWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
