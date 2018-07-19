class ReportsController < ApplicationController

  def learning_target_reports

    # load the learning learning_target_id=16&q%5Bstudent_detail_teacher_id_eq%5D=10

    # look up the appropriate grade for this learning target
    learning_target = LearningTarget.find( params[:learning_target_id] )

    # look up student_id by teacher_id
    student_tpls = Student.find_by_sql "Select b.* from student_details a, users b where b.id = a.student_id and a.teacher_id = #{params[:q][:student_detail_teacher_id_eq]} and type = 'Student' order by b.last_name, b.first_name"

    csv_string = CSV.generate do |csv|
        # header row
        csv << %w(Name V1 V2 V3)

        # add a row for each item
        student_tpls.each do |rr|
            learning_target_tpls = LearningResult.find_by_sql "Select a.* from learning_results a where a.learning_target_id=#{params[:learning_target_id]} and a.student_id = #{rr.id}"

            # skip if the student's grade doesn't match this learning target's grade
            next if learning_target.grade != Student.grade_by_graduation_year(rr.graduation_year)

            record_map = {}
            learning_target_tpls.each do |lt|
                record_map[lt.version] = lt.score
            end
            # look up 3 Learning Results by student_id and learning_target_id
            csv << ["#{rr.last_name}, #{rr.first_name}", record_map.fetch(1, "-"), record_map.fetch(2, "-"), record_map.fetch(3, "-")]
        end
    end
    respond_to do |format|
        format.csv do
            send_data(csv_string, :filename => "learning_results_report.csv")
        end
    end
  end

end
