defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  alias Wabanex.IMC

  describe "caculate/1" do
    test "when the file exists, returns the data" do
      params = %{"filename" => "students.csv"}

      response = IMC.calculate(params)

      expected_response =
        {:ok,
         %{
           "Karla" => 21.773842357381334,
           "Miqueias" => 38.062283737024224,
           "Pedrina" => 26.026174895895306,
           "Ramon" => 23.355636914530994,
           "Rayane" => 25.71166207529844,
           "Renan" => 24.44727891156463
         }}

      assert response == expected_response
    end

    test "when the wrong filename is given, returns an error" do
      params = %{"filename" => "banana.csv"}

      response = IMC.calculate(params)

      expected_response = {:error, "Error while opening the file"}

      assert response == expected_response
    end
  end
end
