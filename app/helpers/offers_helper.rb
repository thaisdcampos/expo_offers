module OffersHelper
  def start_date(date)
    date.strftime('%d/%m/%Y')
  end

  def has_end_date?(date)
    date.nil? ? '-' : date.strftime('%d/%m/%Y')
  end

  def current_status(status)
    case status
    when 'enabled'
      'Ativa'
    when 'disabled'
      'Inativa'
    else
      '-'
    end
  end

  def offer_premium?(premium)
    premium ? 'Sim' : 'Não'
  end
end
