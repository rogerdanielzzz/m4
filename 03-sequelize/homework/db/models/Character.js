const { DataTypes } = require('sequelize');

module.exports = sequelize => {
  sequelize.define('Character', {
    code:{
      type: DataTypes.STRING(5),
      allowNull: false,
      primaryKey:true,

  },
  name:{
      type:DataTypes.STRING,
      allowNull: false,
      unique: true,
      
  },
  age:{
      type: DataTypes.INTEGER,
  },
  race:{
    type: DataTypes.ENUM('Human', 'Elf', 'Machine', 'Demon', 'Animal', 'Other'),
    defaultValue:'Other',
  },
  hp:{ 
    type: DataTypes.FLOAT,
    allowNull: false,


  },
  mana:{ 
    type: DataTypes.FLOAT,
    allowNull: false,


  },
  date_added:{
    type: DataTypes.DATEONLY,
    defaultValue: DataTypes.NOW,
  }


  },{
    timestamps: false,
  })
}

/*Character
--code*: string (Máximo 5 caracteres) [PK]
name*: string (Debe ser único)
--age: integer
--race: enum (Posibles valores: 'Human', 'Elf', 'Machine', 'Demon', 'Animal', 'Other')
--hp*: float
--mana*: float
date_added: timestamp without time
En el caso de no setear una raza ("race") por default deberían asignarle "Other" y si no damos valor para "date_added" debería tomar la fecha actual. Adicionalmente queremos quitar los timestamps automáticos de createdAt y updatedAt.*/ 