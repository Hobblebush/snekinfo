defmodule Snekinfo.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Snekinfo.Users` context.
  """

  def unique_user_name, do: "User#{System.unique_integer()}"
  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def unique_staff_email, do: "user#{System.unique_integer()}@reptigene.com"
  def valid_user_password, do: "hello world!"

  def valid_user_attributes(attrs \\ %{}) do
    email = if attrs[:staff?] do
      unique_staff_email()
    else
      unique_user_email()
    end

    Enum.into(attrs, %{
      email: email,
      name: unique_user_name(),
      password: valid_user_password(),
      staff?: false,
    })
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attributes()
      |> Snekinfo.Users.register_user()

    user
  end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end
end
