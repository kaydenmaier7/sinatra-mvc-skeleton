helpers do

  MAX_SCORE = 100;
  EMPLOYER_REQS = ["Closer", "Evangelist", "Charmer", "Shark"]

  def assessment
    if logged_in?
      @assessment = Assessment.find_by(user_id: @user.id)
    end
  end

  def completed_at
    assessment.updated_at.strftime('%b-%d-%Y')
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
      if !EMPLOYER_REQS.include?(trait.first) && idx < EMPLOYER_REQS.length
        p "here"
      end
    end

  end

  def traitify_results

    access = User.traitify_access

    results = access.find_results(assessment.key)

    short_results = shorten(results)

    rate_short_results(short_results)

  end

end
