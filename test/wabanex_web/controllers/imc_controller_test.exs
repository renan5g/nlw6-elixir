defmodule WabanexWeb.IMCControllerTest do
  use WabanexWeb.ConnCase, async: true

  describe "index/2" do
    test "when all params are valid, returns the imc info", %{conn: conn} do
      params = %{"filename" => "students.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:ok)

      expected_response = %{
        "result" => %{
          "Karla" => 21.773842357381334,
          "Miqueias" => 38.062283737024224,
          "Pedrina" => 26.026174895895306,
          "Ramon" => 23.355636914530994,
          "Rayane" => 25.71166207529844,
          "Renan" => 24.44727891156463
        }
      }

      assert response == expected_response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = %{"filename" => "banana.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:bad_request)

      expected_response = %{"result" => "Error while opening the file"}

      assert response == expected_response
    end
  end
end
