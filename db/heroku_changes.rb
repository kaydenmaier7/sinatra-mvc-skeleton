# def sort_db

#   elements = Assessment.all

#   elements = elements.select { |element| !element.score.nil? }
#   sorted_results = elements.sort_by { |item| -item.score }

#   sorted_results.each do |res|
#     user = User.find(res.id)
#     p user.username.to_s + ' got a ' + res.score.to_s
#     p user.email.to_s
#     p "*" * 20
#   end

#   nil

# end

# sort_db

# POSTGRES EQUIVALENT

SELECT users.id, username, email, score, assessments.updated_at
FROM users
INNER JOIN assessments ON users.id = assessments.user_id
WHERE assessments.score IS NOT NULL
ORDER BY assessments.score DESC;

# POSTGRESS TO ADD COLUMN TO ONLINE DATABASE

# ALTER TABLE users
# ADD COLUMN "special" BOOLEAN NOT NULL DEFAULT FALSE;
