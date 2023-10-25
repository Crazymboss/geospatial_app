class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    json_data_path = Rails.root.join('app','assets', 'sample.json')
    data = File.read(json_data_path)
    data_hash = JSON.parse(data.to_s)

    #Ticket info
    rn = data_hash['RequestNumber']
    sn = data_hash['SequenceNumber']
    rt = data_hash['RequestType']
    ra = data_hash['RequestAction']
    dt = data_hash['DateTimes']['ResponseDueDateTime']
    sa = data_hash['ServiceArea']['PrimaryServiceAreaCode']['SACode']
    sa2 = data_hash['ServiceArea']['AdditionalServiceAreaCodes']['SACode']
    dig = data_hash['ExcavationInfo']['DigsiteInfo']
    wkt = data_hash['ExcavationInfo']['DigsiteInfo']['WellKnownText']

    #Excavator info
    cn = data_hash['Excavator']['CompanyName']
    adr = data_hash['Excavator']['Address']+' '+ data_hash['Excavator']['City']+' '+data_hash['Excavator']['State']+' '+data_hash['Excavator']['Zip']
    crew = data_hash['Excavator']['CrewOnsite']
    ticket = Ticket.create(request_number: rn, sequence_number: sn, request_type: rt, request_action: ra, response_due_date_time: dt, primary_service_area_code: sa, additional_service_area_codes: sa2, well_known_text: wkt, digsite_info: dig)
    excavator = ticket.excavators.create(company_name: cn, address: adr, crew_on_site: crew)

    if ticket.valid? && excavator.valid?
      render json: { message: 'Data saved successfully' }, status: :created
    else
      render json: { errors: ticket.errors.full_messages + excavator.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
