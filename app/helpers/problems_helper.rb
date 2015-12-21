module ProblemsHelper
  def get_name
    "Problem " + @problem.number.to_s + (@problem.part ? "." + @problem.part : "")
  end
end
