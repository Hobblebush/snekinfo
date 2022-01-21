defmodule Snekinfo.Photos.Upload do
  alias Snekinfo.Photos.Photo
  alias Snekinfo.Snakes.Snake

  def photo_dir(%Snake{} = snake) do
    photo_dir(snake.id)
  end
  def photo_dir(%Photo{} = photo) do
    photo_dir(photo.snake_id)
  end
  def photo_dir(snake_id) do
    sn = String.pad_leading("#{snake_id}", 4, "0")
    if Application.get_env(:snekinfo, :config_env) == :test do
      "/tmp/snekinfo_test/photos/#{sn}"
    else
      Path.expand("~/.local/data/snekinfo/photos/#{sn}")
    end
  end

  def photo_path(%Photo{} = photo) do
    pdir = photo_dir(photo)
    File.mkdir_p!(pdir)
    numb = String.pad_leading("#{photo.id}", 4, "0")
    Path.join(pdir, "#{numb}.jpg")
  end

  def thumb_path(%Photo{} = photo) do
    pdir = photo_dir(photo)
    File.mkdir_p!(pdir)
    numb = String.pad_leading("#{photo.id}", 4, "0")
    Path.join(pdir, "#{numb}-512.jpg")
  end

  def save_upload!(%Photo{} = photo, %{"upload" => upload}) do
    if jpeg?(upload.path) do
      File.copy!(upload.path, photo_path(photo))
      make_thumbnail!(photo)
    else
      raise "That's not a JPEG"
    end
  end
  def save_upload!(_, _), do: nil

  def delete_upload!(%Photo{} = photo) do
    photo_path(photo) |> delete_jpeg!()
    thumb_path(photo) |> delete_jpeg!()
  end

  def delete_jpeg!(path) do
    if jpeg?(path) do
      File.rm!(path)
    end
  end

  def jpeg?(path) do
    {text, 0} = System.cmd("file", ["-b", "--mime-type", path])
    String.trim(text) == "image/jpeg"
  end

  def make_thumbnail!(photo) do
    inp = photo_path(photo)
    out = thumb_path(photo)
    {_, 0} = System.cmd("convert", [inp, "-resize", "512x512", out])
  end
end
