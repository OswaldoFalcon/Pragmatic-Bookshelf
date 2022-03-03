defmodule Taxes do
  def taxes_add(orders, tax_rates) do

    nc = tax_rates[:NC]
    tx = tax_rates[:TX]
   #calcula y agrega a un nuevo mapa los nuevos taxes#
    tax_nc = orders |> Enum.filter(fn x -> x.ship_to == :NC end) |> Enum.map(fn x -> Map.put(x, :total_amount, (x.net_amount * nc) + x.net_amount) end )
    tax_tx = orders |> Enum.filter(fn x -> x.ship_to == :TX end) |> Enum.map(fn x -> Map.put(x, :total_amount, (x.net_amount * tx) + x.net_amount) end )
    new_taxes = tax_nc ++ tax_tx

    #eliminar NC y TX
    sin = orders |> Enum.filter(fn x -> x.ship_to != :NC and x.ship_to != :TX  end) |> Enum.map(fn x -> Map.put(x, :total_amount, x.net_amount) end )


    #junta 
    sin ++ new_taxes
  end
end
