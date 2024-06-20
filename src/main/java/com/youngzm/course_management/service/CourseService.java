package com.youngzm.course_management.service;

import com.youngzm.course_management.entity.Course;
import com.youngzm.course_management.repository.CourseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CourseService {
    @Autowired
    private CourseRepository courseRepository;

    public Course saveCourse(Course course) {
        return courseRepository.save(course);
    }

    public List<Course> getAllCourses() {
        return courseRepository.findAll();
    }

    public Course getCourseByID(Long courseId) {
        return courseRepository.findById(courseId).orElse(null);
    }

    public List<Course> getCourseByTeacherId(Long teacherId) {
        return courseRepository.findByTeachersId(teacherId);
    }

    public List<Course> getCoursesByTerm(String term) {
        return courseRepository.findByTerm(term);
    }

    public List<Course> getCoursesBySchool(String school) {
        return courseRepository.findBySchool(school);
    }

    public void deleteCourse(Long id) {
        courseRepository.deleteById(id);
    }

    public Course updateCourse(Long id, Course course) {
        Course existingCourse = courseRepository.findById(id).orElseThrow(() -> new RuntimeException("Course not found"));
        course.setId(id);
        course.setTeachers(existingCourse.getTeachers());
        return courseRepository.save(course);
    }

}
