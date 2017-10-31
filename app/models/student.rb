# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  type                   :string
#  first_name             :string
#  last_name              :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_id_and_type           (id,type) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class Student < User

  has_one :student_detail
  has_one :teacher, through: :student_detail
  has_many :learning_results
  has_many :achievements, through: :learning_results
  has_many :learning_targets, through: :learning_results

  delegate :graduation_year, :english_second_language, :individualized_education_plan, :teacher_id, to: :student_detail, allow_nil: true

  accepts_nested_attributes_for :student_detail, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }

  # ==========
  # = Scopes =
  # ==========
  scope :grade, ->(grade){ joins(:student_detail).where(student_details: {graduation_year: graduation_year_by_grade(grade)}) }
  scope :teacher, ->(teacher){ joins(:student_detail).where(student_details: {teacher_id: teacher.id}) }

  # =================
  # = Class Methods =
  # =================
  def self.graduation_year_by_grade(grade)
    left = 8 - grade
    today = Date.today
    if today.month > 7
      left += 1
    end
    today.year + left
  end

  def self.grade_by_graduation_year(year)
    today = Date.today
    diff = year - today.year
    if today.month > 7
      diff -= 1
    end
    8 - diff
  end

  # ===========
  # = Getters =
  # ===========
  def grade
    @grade ||= Student.grade_by_graduation_year(graduation_year)
  end

  def score(results, version)
    result_by_version(results, version).try(:score)
  end

  def notes(results, version)
    result_by_version(results, version).try(:notes)
  end

  def result_by_version(results, version)
    results.detect{ |result| result.student_id == id && result.version == version }
  end

  def name
    [first_name, last_name].join(' ')
  end

end
