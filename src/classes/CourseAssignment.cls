public class CourseAssignment {
    
    public static Map<String, List<recommendedCourse>> getSuggestedCourses (List<Student__c> students) {
        Map<String,List<String>> mapSkillNameDiscipline = new Map<String,List<String>>();
        Map<String,List<String>> mapStudentNamePreferences = new Map<String,List<String>>();
        Map<String,Course__c> mapCourseName = new Map<String,Course__c>();
        Map<String, List<recommendedCourse>> mapStudentNameCourcePercentFit = new Map<String, List<recommendedCourse>>();
        List<recommendedCourse> listRecStudentCourses = new List<recommendedCourse>();
        List<String> liststudentsNames = new List<String>();

        if(!students.isEmpty()){
            List<Student__c> listcurrentStudents = [SELECT Name FROM Student__c WHERE Id IN : students];
            
            for(Student__c student : listcurrentStudents){
                liststudentsNames.add(student.Name);
            }
    
            List<Preferences__c> listPreferences = [SELECT Student__r.Name,Skill__r.Name FROM Preferences__c WHERE Student__c IN:students];
            List<Discipline__c> listDisciplines = [SELECT Course__r.Name,Skill__r.Name,Course__c FROM Discipline__c];
            List<Course__c> listCourseObj = [SELECT Id,Name FROM Course__c];
    
            for(Preferences__c preference: listPreferences){
                if(!mapStudentNamePreferences.containsKey(preference.Student__r.Name)){
                    mapStudentNamePreferences.put(preference.Student__r.Name, new List<String>());
                }
               mapStudentNamePreferences.get(preference.Student__r.Name).add(preference.Skill__r.Name);
            }
    
            for(Discipline__c discipline: listDisciplines){
                 if(!mapSkillNameDiscipline.containsKey(discipline.Course__r.Name)){
                    mapSkillNameDiscipline.put(discipline.Course__r.Name, new List<String>());
                }
               mapSkillNameDiscipline.get(discipline.Course__r.Name).add(discipline.Skill__r.Name);
            }
            
            for(Course__c obj: listCourseObj){
                mapCourseName.put(obj.Name, obj);
            }
            
            system.debug('mapCourseName-----------'+mapCourseName);
            for(String student : mapStudentNamePreferences.keySet()){
                for(String course : mapSkillNameDiscipline.keySet()){
                    listRecStudentCourses.add(new recommendedCourse(student, mapCourseName.get(course), mapStudentNamePreferences.get(student),mapSkillNameDiscipline.get(course)));
                }
            }
            for(String studentName : liststudentsNames){
                List<recommendedCourse> recommendedCoursesObjects = new List<recommendedCourse>();
                for(recommendedCourse obj : listRecStudentCourses){
                    if(obj.name == studentName){
                       recommendedCoursesObjects.add(new recommendedCourse(obj.course,obj.percent));
                    }
                }
                mapStudentNameCourcePercentFit.put(studentName, recommendedCoursesObjects);
            }
            system.debug('mapStudentNameCourcePercentFit----------'+mapStudentNameCourcePercentFit);
        }
        return mapStudentNameCourcePercentFit;
    }

   public class recommendedCourse {
       public Integer percentCompliance;
       public Course__c course;

       public String name;
       public Integer percent;

       public recommendedCourse(Course__c course, Integer compliance) {
          this.course = course;
          this.percentCompliance = compliance;
       }
       
       public recommendedCourse(String name, Course__c course, List<String> listStudentSkill,List<String> listCourseSkill){
          Integer rPercent;
          Integer counter = 0;

          for(String disc: listCourseSkill){
              if(listStudentSkill.contains(disc)){
                  counter += 1;
              }
          }

          rPercent = (Integer)Math.roundToLong(((Decimal)counter/(Decimal)listStudentSkill.size())*100);

          if(rPercent> 100){
              this.percent = 100;
          } else {
              this.percent = rPercent;
          }

          this.name = name;
          this.course = course;
          }
    }
}