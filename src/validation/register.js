import Validator from 'validator';
import isEmpty from './isEmpty';

function validateRegisterForm(data) {
  let errors = {};

  data.firstname = !isEmpty(data.firstname) ? data.firstname : '';
  data.lastname = !isEmpty(data.lastname) ? data.lastname : '';
  data.email = !isEmpty(data.role) ? data.role : '';
  data.phone = !isEmpty(data.username) ? data.username : '';
  data.dateOfBirth = !isEmpty(data.email) ? data.email : '';
  data.password = !isEmpty(data.password) ? data.password : '';

  if (!Validator.isLength(data.firstname, { min: 2, max: 30 })) {
    errors.firstname = 'First Name must be between 2 and 30 character long';
  }

  if (!Validator.isLength(data.lastname, { min: 2, max: 30 })) {
    errors.lastname = 'Last Name must be between 2 and 30 character long';
  }

  if (Validator.isEmpty(data.firstname)) {
    errors.firstname = 'First Name field is required';
  }

  if (Validator.isEmpty(data.lastname)) {
    errors.lastname = 'Last Name field is required';
  }

  // if (Validator.isEmpty(data.email)) {
  //   errors.email = 'Email field is required';
  // }

  if (Validator.isEmpty(data.phone)) {
    errors.phone = 'Phone field is required';
  }

  if (Validator.isEmpty(data.dateOfBirth)) {
    errors.dateOfBirth = 'Date of Birth field is required';
  }

  if (!Validator.isEmail(data.email)) {
    errors.email = 'email is invalid';
  }

  if (Validator.isEmpty(data.password)) {
    errors.password = 'password field is required';
  }

  if (!Validator.isLength(data.password, { min: 6, max: 30 })) {
    errors.password = 'password must be at least 6 characters long';
  }

  return {
    errors,
    isValid: isEmpty(errors),
  };
};

export default validateRegisterForm;