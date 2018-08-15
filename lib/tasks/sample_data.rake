require 'factory_girl'

namespace :db do
  desc "Reset database and then fill it with sample data"
  task populate: [:environment, :reset] do
    FactoryGirl.create(:organization)
    FactoryGirl.create(:term100)
    FactoryGirl.create(:term200)
    FactoryGirl.create(:term300)
    FactoryGirl.create(:term400)
    FactoryGirl.create(:term500)
    FactoryGirl.create(:course)
    c = FactoryGirl.create(:course_offering_term_1_tr)
    c2 = FactoryGirl.create(:course_offering_term_1_mwf)
    c3 = FactoryGirl.create(:course_offering_term_2_tr)
    FactoryGirl.create(:course_offering_term_2_mwf)
    FactoryGirl.create(:course_offering_term_3_tr)
    FactoryGirl.create(:course_offering_term_3_mwf)
    FactoryGirl.create(:course_offering_term_5_mwf)
    FactoryGirl.create(:course_offering_term_5_tr)

    FactoryGirl.create(:course_enrollment,
      user: FactoryGirl.create(:admin),
      course_offering: c,
      course_role: CourseRole.instructor)

    instructor = FactoryGirl.create(:confirmed_user,
      first_name: 'Ima',
      last_name:  'Teacher',
      email:      "example-1@railstutorial.org")

    instructor2 = FactoryGirl.create(:confirmed_user,
      first_name: 'Another',
      last_name: 'Teacher',
      email: 'example-2@railstutorial.org')

    FactoryGirl.create(:course_enrollment,
      user: instructor,
      course_offering: c,
      course_role: CourseRole.instructor)

    FactoryGirl.create(:course_enrollment,
      user: instructor,
      course_offering: c2,
      course_role: CourseRole.instructor)

    FactoryGirl.create(:course_enrollment,
      user: instructor2,
      course_offering: c3,
      course_role: CourseRole.instructor)

    50.times do |n|
      co = nil
      if n < 16
        co = c
      elsif n < 32
        co = c2
      else
        co = c3
      end
      FactoryGirl.create(:course_enrollment,
        user: FactoryGirl.create(:confirmed_user,
          first_name: Faker::Name.first_name,
          last_name:  Faker::Name.last_name,
          email:      "example-#{n+3}@railstutorial.org"),
        course_offering: co)
    end

    # Create a workout with one exercise, and a second exercise
    w = FactoryGirl.create :workout_with_exercises
    FactoryGirl.create :coding_exercise, name: 'Factorial 3'

    user_group = FactoryGirl.create :user_group
    user_group.users << [ instructor, instructor2 ]

    group_owned_collection = FactoryGirl.create :group_owned_collection, id: 1
    user_group.exercise_collection = group_owned_collection

    single_user_collection = FactoryGirl.create :user_owned_collection
    instructor.exercise_collection = single_user_collection

    FactoryGirl.create :mc_exercise, name: 'Pick One 3', exercise_collection: group_owned_collection
    FactoryGirl.create :mc_exercise, name: 'Pick One 4', exercise_collection: group_owned_collection
    FactoryGirl.create :coding_exercise, name: 'User Owned Coding', exercise_collection: single_user_collection
    FactoryGirl.create :mc_exercise, name: 'User Owned MCQ', exercise_collection: single_user_collection

    # Create a workout_offering
    FactoryGirl.create :workout_offering
    FactoryGirl.create(:workout_offering,
      course_offering: c3,
      workout: w)
  end

  desc "Reset database and then fill it with Summer I 2015 data"
  task populate_su15: [:environment, :reset] do
    FactoryGirl.create(:organization)
    FactoryGirl.create(:term,
       season: 200,
       starts_on: "2015-05-25",
       ends_on: "2015-07-07",
       year: 2015)
    FactoryGirl.create(:course)
    c = FactoryGirl.create(:course_offering,
      self_enrollment_allowed: true,
      url: 'http://moodle.cs.vt.edu/course/view.php?id=282',
      label: '60396'
      )
    FactoryGirl.create(:course_enrollment,
      user: FactoryGirl.create(:admin),
      course_offering: c,
      course_role: CourseRole.instructor)
  end

end
