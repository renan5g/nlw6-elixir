defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "users queries" do
    test "when a valid id is given, returns the user", %{conn: conn} do
      params = %{email: "renan@test.com", name: "Renan", password: "123456"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
      {
        getUser(id: "#{user_id}") {
          email
          name
        }
      }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "getUser" => %{
            "email" => "renan@test.com",
            "name" => "Renan"
          }
        }
      }

      assert response == expected_response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      query = """
      {
        getUser(id: "04fcfa07-e42a-4444-85df-c3a349e61fb3") {
          email
          name
        }
      }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{"getUser" => nil},
        "errors" => [
          %{
            "locations" => [%{"column" => 3, "line" => 2}],
            "message" => "User not found",
            "path" => ["getUser"]
          }
        ]
      }

      assert response == expected_response
    end
  end

  describe "users mutations" do
    test "when all params are valid, creates the user", %{conn: conn} do
      mutation = """
        mutation {
          createUser(input: {
              name: "Joao", email: "test@test.com", password: "animo123"
            }){
              id
              name
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{"data" => %{"createUser" => %{"id" => _id, "name" => "Joao"}}} = response
    end
  end
end
