puts "== Seeding Users...\n\n"

if Rails.env == "development"
  ADMIN_NAMES = %w(admin root owner)
else
  ADMIN_NAMES = %w(nhb7817 jopitts bward dli6873)
end
  
ADMIN_NAMES.each do |eid|
  
  user = User.new do |u|
    u.admin = true
    u.eid = eid
    u.name = eid
  end

  if User.find_by_eid(eid)
    puts "#{eid} already exists"
  else
    user.save
    puts "Created admin #{eid}"
  end
end

if Rails.env == "development"
  for i in (0..100)
    user = User.new do |u|
      u.admin = false
      u.eid = "player " + i.to_s
      u.name = "player " + i.to_s
      u.accepted_terms_and_conditions = true
    end
    puts user.save
  end
end
