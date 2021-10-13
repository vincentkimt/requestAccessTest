//below is object
const student = {
    name:"jhon",
    age:23,
    isPresent: true,
    fees: undefined,
    datesWhenAbsent:[2,3,4,7],
    address:{
        street:"2nd St",
        pincode:'244001',
        city:"abc",
    }
    
};//object
console.log(student);
// another way of printing array 
console.log(Object.entries(student));

console.log(Object.keys(student));
console.log(Object.values(student));
console.log(student.age);//print value
console.log(student.name);//print value
console.log(student["age"]);//print value
console.log(student["name"]);//print value

//delete
delete student.fees;//removes the element

console.log("Jhon is absent on ",student.datesWhenAbsent);
//

//below is array storing object
const studentDetails=[student,{
    name:"Harry",
    age:29,
    isPresent: false,
    fees: undefined,
    datesWhenAbsent:[4,7],
    address:{
        street:"3rd St",
        pincode:'244001',
        city:"mbd",
    }
}]//array

console.log("Students::"+JSON.stringify(studentDetails));