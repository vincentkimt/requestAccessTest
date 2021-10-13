const studentNames=studentDetails.map(function(student){
    return student.name;//return name only
})

console.log(studentNames);
//below is example, where the .filter is used on array and later in same we used .map to get names
//so inner return statement return the array element. and later map function return student name only.
//in the map the arrow function is used.
const absentStudents=studentDetails.filter(function(student){
    return (student.isPresent === false);


}).map((student) => student.name)

console.log(absentStudents);