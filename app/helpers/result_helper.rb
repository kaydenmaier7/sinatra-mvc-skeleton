helpers do

  MAX_SCORE = 100
  NEG_TRAIT_SCORE_MULT = 0.125
  POS_TRAIT_SCORE_MULT = 0.1
  DEDUCT_POINT = 5
  EMPLOYER_REQS = ["Closer", "Evangelist", "Charmer", "Shark"]

  def assessment
    if logged_in?
      @assessment = Assessment.find_by(user_id: @user.id)
    end
  end

  def completed_at
    assessment.updated_at.strftime('%b %d, %Y')
  end


  def shorten(results)
    shortened_results = {}
    results['personality_types'].each do |personality|
      shortened_results[personality['personality_type']['name']] = personality['score']
    end
    return shortened_results
  end

  def rate_short_results(results_arr)
    result = MAX_SCORE
    results_arr.each_with_index do |trait, idx|
      multiplier = (idx * 0.2)
      if !EMPLOYER_REQS.include?(trait.first) && idx <= EMPLOYER_REQS.length
        result -= DEDUCT_POINT * multiplier + (trait[1] * NEG_TRAIT_SCORE_MULT)
      else
        result -= ((MAX_SCORE - trait[1]) * POS_TRAIT_SCORE_MULT) * multiplier
      end
    end
    result.round(2)
  end

  def traitify_results

    access = User.traitify_access

    results = access.find_results(assessment.key)

    short_results = shorten(results)

    rate_short_results(short_results)

  end

end
