namespace :dev do
  desc "Sample data for local development environment"
  task prime: :environment do
    round = Round.find_or_create_by(
      name: Date.today.beginning_of_week(:tuesday).to_s(:long)
    )

    [
      "4WD or SUV",
      "Amenities only",
      "Attendant outside",
      "Aussie pride",
      "Black car",
      "Blue car",
      "Car with trailer",
      "Flanno",
      "Ice ice baby",
      "Jerk on mobile phone",
      "Jerry can",
      "L-Plater",
      "Mass exodus",
      "Motorcycle",
      "Night Walker",
      "PJ's",
      "Police car",
      "P-Plater",
      "Red/orange car",
      "Refuelling truck",
      "Silver car",
      "Snack monster",
      "Taxi",
      "Tradie",
      "Truck",
      "Tyres pumping",
      "Ute",
      "Ute - dog in back",
      "Ute - dual cab",
      "Van",
      "White car",
      "Windscreen washer"
    ].each do |call|
      Call.create(name: call, round: round)
    end
  end
end
