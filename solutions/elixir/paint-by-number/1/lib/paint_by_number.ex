defmodule PaintByNumber do

  def palette_bit_size(colour_count) do
    get_bitdepth(colour_count)
  end

  defp get_bitdepth(colour_count, exp \\ 1) do
    if 2 ** exp >= colour_count do
      exp
    else
      get_bitdepth(colour_count, exp + 1)
    end
  end

  def empty_picture() do
    ""
  end

  def test_picture() do
    << 0::2, 1::2, 2::2, 3::2 >>
  end

  def prepend_pixel(picture, colour_count, pixel_color_index) do
    bitsize = palette_bit_size(colour_count)
    << pixel_color_index::size(bitsize), picture::bitstring >>
  end

  def get_first_pixel("", _), do: nil
  def get_first_pixel(picture, colour_count) do
    bitsize = palette_bit_size(colour_count)
    << value::size(bitsize), _::bitstring >> = picture
    value
  end

  def drop_first_pixel("", _), do: ""
  def drop_first_pixel(picture, colour_count) do
    bitsize = palette_bit_size(colour_count)
    << _::size(bitsize), value::bitstring >> = picture
    value
  end

  def concat_pictures(picture1, picture2) do
    << picture1::bitstring, picture2::bitstring >>
  end
end
