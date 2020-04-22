# frozen_string_literal: true

Offer.create!(advertiser_name: 'Oferta de comida', url: 'www.big.com.br', description: 'Super desconto no big', active_from: Date.current, premium: true, status: :enabled)
Offer.create!(advertiser_name: 'Oferta de roupa', url: 'www.dafiti.com.br', description: 'Super desconto na dafiti', active_from: Date.current, premium: true, status: :disabled)
Offer.create!(advertiser_name: 'Oferta de esportes', url: 'www.centauro.com.br', description: 'Desconto na centauro', active_from: Date.current, premium: false, status: :disabled)
Offer.create!(advertiser_name: 'Oferta de calçados', url: 'www.netshoes.com.br', description: 'Desconto em calçados', active_from: Date.current, active_until: (Date.current + 2.days), premium: false, status: :enabled)
Offer.create!(advertiser_name: 'Oferta de brinquedos', url: 'www.hihappy.com.br', description: 'Desconto em brinquedos', active_from: Date.current, active_until: (Date.current + 1.day), premium: false, status: :enabled)
