export default (sequelize, DataTypes) => {
  const User = sequelize.define(
    'User',
    {
      firstname: DataTypes.STRING,
      lastname: DataTypes.STRING,
      email: DataTypes.STRING,
      phone: DataTypes.STRING,
      dateOfBirth: DataTypes.STRING,
      password: DataTypes.STRING,
    },
    {}
  );

  User.associate = function(models) {
    // associations go here
  };

  return User;
};
