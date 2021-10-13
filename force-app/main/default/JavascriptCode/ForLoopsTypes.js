const studentsarray=["Jhon","Harry","Ron","Don","Nonoy"];
//Example 1
for(let student of studentsarray){
    console.log(student)
}
//Example 2
for(let student of studentDetails){
    console.log(student.name);
    console.log(student.age);
    console.log(student.isPresent);
}

//example 3
for (let prop in student) {
    console.log(`${prop} : ${student[prop]}`);
  }


//for Each Loops on Array : act as method for the array
//studentDetails.forEach(function(arrayElement,IndexOfTheArrayOfElementCurrentlyExecutingInLoop,arrayItself))
studentDetails.forEach(function(studentElement){
    
})
