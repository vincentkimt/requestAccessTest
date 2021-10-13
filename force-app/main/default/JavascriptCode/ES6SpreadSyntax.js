const newStudents=[
    {
        name:"lilly",
        age:25,
        isPresent:false
    }
];
//combining above and main arrary
const totalStudents = [...studentDetails,...newStudents];

console.log('total students--',totalStudents);

//getting first three elements from array
console.log('getting first three elements from array');
const [jo,ko,lo]= totalStudents;//get 0,1,2 index elements ... give more on left side if need more elemts
console.log(jo);
console.log(ko);
console.log(lo);

//new object
oldStudentObject={
    name:"Luci",
    age:28,
    
}
newStudentObject={
   
    oldSchool:"St Marry",//new property will go to combined object
}
//combining(Properties only) above and the main object into 1. and saving it in third object
const studentObjectCombined = {...oldStudentObject,...newStudentObject,age:30};
console.log('combined is:::::')
console.log(studentObjectCombined);//with new age as 30



//destructuring

const {name,isPresent} = student;//usefull in JSON reading so that we get the specified property from it.

console.log(name);
console.log(isPresent)