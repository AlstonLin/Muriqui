module ProblemsHelper
  def get_name
    "Problem " + @problem.number.to_s + (@problem.part ? "." + @problem.part.to_s : "")
  end
end
