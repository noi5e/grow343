class ReportsController < ApplicationController

    GOOD_PERFORMANCE_COLOR = "#8daa92"
    OK_PERFORMANCE_COLOR = "#e29b20"
    BAD_PERFORMANCE_COLOR = "#d45f53"

    def generate_csv_string(learning_target, student_tpls)
        csv_string = CSV.generate do |csv|
            # header row
            csv << %w(Name V1 V2 V3)

            # add a row for each item
            student_tpls.each do |rr|
                learning_target_tpls = LearningResult.find_by_sql "Select a.* from learning_results a where a.learning_target_id=#{params[:learning_target_id]} and a.student_id = #{rr.id}"

                # skip if we don't find any students with this learning target
                next if learning_target_tpls.size < 1

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
        csv_string
    end

    # determine the display colors
    def color_cues(record_map, current_key)
        return OK_PERFORMANCE_COLOR if record_map.fetch(1, "-") == "-" ||  record_map.fetch(current_key, "-") == "-"

        # compare current key to now
        if record_map[current_key] > record_map[1]
            return GOOD_PERFORMANCE_COLOR
        elsif record_map[current_key] == record_map[1]
            return OK_PERFORMANCE_COLOR
        else
            return BAD_PERFORMANCE_COLOR
        end
    end

    # for rendering the print friendly version, we'll pre-gather all the values
    def generate_learning_result_tuples(learning_target, student_tpls)
        school_year_begin_yr = Time.now.month >= 9 ? Time.now.year : Time.now.year-1

        result_tpls = []
        student_tpls.each do |rr|
            learning_target_tpls = LearningResult.find_by_sql "Select a.* from learning_results a where a.learning_target_id=#{params[:learning_target_id]} and a.student_id = #{rr.id} and updated_at > '#{school_year_begin_yr}-09-01'"

            # skip if we don't find any students with this learning target
            next if learning_target_tpls.size < 1

            # skip if the student's grade doesn't match this learning target's grade
            next if learning_target.grade != Student.grade_by_graduation_year(rr.graduation_year)

            record_map = {}
            learning_target_tpls.each do |lt|
                record_map[lt.version] = lt.score
            end

            # look up 3 Learning Results by student_id and learning_target_id
            result_tpls.push(["#{rr.last_name}, #{rr.first_name}", record_map.fetch(1, "-"), color_cues(record_map, 2), record_map.fetch(2, "-"), color_cues(record_map, 3), record_map.fetch(3, "-")])
        end
        result_tpls
    end

    # main erb method
    def learning_target_reports

        # look up the appropriate grade for this learning target
        learning_target = LearningTarget.find( params[:learning_target_id] )

        # look up student_id by teacher_id
        teacher_clause = "and a.teacher_id = #{params[:q][:student_detail_teacher_id_eq]}" if params[:q][:student_detail_teacher_id_eq].size > 0 else ""

        student_tpls = Student.find_by_sql "Select b.* from student_details a, users b where b.id = a.student_id #{teacher_clause} and type = 'Student' order by b.last_name, b.first_name"

        respond_to do |format|
            format.html do
                # the result of this has the correct number of students
                results = generate_learning_result_tuples(learning_target, student_tpls)
                render "learning_target_report", :layout => "printable.html.erb", :locals => { :result_tpls => results }
            end
            format.csv do
                csv_string = generate_csv_string(learning_target, student_tpls)
                send_data(csv_string, :filename => "learning_results_report.csv")
            end
        end
    end
end
