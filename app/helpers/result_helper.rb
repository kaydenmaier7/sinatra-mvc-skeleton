helpers do

  MAX_SCORE = 100
  NEG_TRAIT_SCORE_MULT = 0.125
  POS_TRAIT_SCORE_MULT = 0.1
  DEDUCT_POINT = 5
  EMPLOYER_REQS = ["Politician", "Charmer", "Closer", "Evangelist"]

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


  # Subtracts from the MAX score
  def simple_rate(results_arr)
    result = MAX_SCORE
    results_arr.each_with_index do |trait, idx|
      if !EMPLOYER_REQS.include?(trait.first) && idx < EMPLOYER_REQS.length
        multiplier = 1 - (idx * 0.2)
        result -= DEDUCT_POINT * multiplier + (trait[1] * NEG_TRAIT_SCORE_MULT)
      elsif EMPLOYER_REQS.include?(trait.first)
        multiplier = (EMPLOYER_REQS.index(trait.first) - idx).abs * 0.2
        result -= ((MAX_SCORE - trait[1]) * POS_TRAIT_SCORE_MULT) * multiplier
      else
        multiplier = (results_arr.length - idx) * 0.2
        result -= DEDUCT_POINT * multiplier + (trait[1] * NEG_TRAIT_SCORE_MULT)
      end
    end
    return result.round(2)
  end

  def slide_rate(slides_arr, current_score)
    negative_questions = ["I'll Swallow You Whole",
                          "Revenge",
                          "I Could Hurt You"]
    positive_questions = ["All Must Be Equal",
                          "I'm Working For You"]

    slides_arr.each do |slide|
      if negative_questions.include?(slide.caption) && slide.response
        current_score -= 2
      elsif positive_questions.include?(slide.caption) && !slide.response
        current_score -= 1
      elsif positive_questions.include?(slide.caption) && slide.response
        current_score += 1
      end
    end
    return current_score
  end

  def traitify_results

    access = User.traitify_access
    results = access.find_results(assessment.key)
    slides = access.find_slides(assessment.key)
    short_results = shorten(results)

    return slide_rate(slides, simple_rate(short_results) )
  end

end
