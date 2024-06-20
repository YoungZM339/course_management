package com.youngzm.course_management.service;

import com.youngzm.course_management.dto.AssignRequest;
import com.youngzm.course_management.repository.CourseRepository;
import com.youngzm.course_management.repository.TeacherRepository;
import com.youngzm.course_management.entity.Course;
import com.youngzm.course_management.entity.Teacher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
public class AssignService {
    @Autowired
    private TeacherRepository teacherRepository;

    @Autowired
    private CourseRepository courseRepository;

    @Transactional
    public void assignCourseToTeacher(AssignRequest request) {
        Optional<Teacher> teacherOptional = teacherRepository.findById(request.getTeacherId());
        Optional<Course> courseOptional = courseRepository.findById(request.getCourseId());

        if (teacherOptional.isEmpty()) {
            throw new IllegalArgumentException("Teacher not found with id: " + request.getTeacherId());
        }

        if (courseOptional.isEmpty()) {
            throw new IllegalArgumentException("Course not found with id: " + request.getCourseId());
        }

        Teacher teacher = teacherOptional.get();
        Course course = courseOptional.get();

        teacher.getCourses().add(course);
        course.getTeachers().add(teacher);

        teacherRepository.save(teacher);
    }
}
