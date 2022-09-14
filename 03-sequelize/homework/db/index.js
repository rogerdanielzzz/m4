const { Sequelize, Op } = require("sequelize");
const modelCharacter = require("./models/Character.js");
const modelAbility = require("./models/Ability.js");
const modelRole = require("./models/Role.js");
const { pass } = require("../dont.js");

const db = new Sequelize(
  `postgres://postgres:${pass}@localhost:5432/henry_sequelize`,
  {
    logging: false,
  }
);

modelCharacter(db);
modelAbility(db);
modelRole(db);

const { Character, Ability, Role } = db.models;

// R 1XN
Character.hasMany(Ability);
Ability.belongsTo(Character);
// R NXM
Character.belongsToMany(Role, { through: "CharacterRole" });
Role.belongsToMany(Character, { through: "CharacterRole" });

module.exports = {
  ...db.models,
  db,
  Op,
};