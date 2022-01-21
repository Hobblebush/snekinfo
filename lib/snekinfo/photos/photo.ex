defmodule Snekinfo.Photos.Photo do
  alias __MODULE__

  use Ecto.Schema
  import Ecto.Changeset

  schema "photos" do
    field :caption, :string
    field :filename, :string
    field :order, :integer
    belongs_to :snake, Snekinfo.Snakes.Snake

    timestamps()
  end

  @doc false
  def changeset(%Photo{} = photo, attrs) do
    photo
    |> cast(attrs, [:filename, :caption, :order, :snake_id])
    |> put_filename(attrs)
    |> validate_required([:filename, :order, :snake_id])
  end

  def put_filename(cset, %{"upload" => upload}) do
    put_change(cset, :filename, upload.filename)
  end
  def put_filename(cset, %{upload: upload}) do
    put_filename(cset, %{"upload" => upload})
  end
  def put_filename(cset, _attrs) do
    cset
  end
end
