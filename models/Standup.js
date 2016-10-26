'use strict';

var log = require('../getLogger')('Standup model');

module.exports = function (sequelize, DataTypes) {
  log.verbose('Initializing');
    var Standup = sequelize.define('Standup', {
        channel: {
          type: DataTypes.STRING
        },
        date: {
            type: DataTypes.DATEONLY
        },
        user: {
            type: DataTypes.STRING
        },
        userRealName: {
            type: DataTypes.STRING
        },
        thumbUrl: {
            type: DataTypes.STRING
        },
        yesterday: {
            type: DataTypes.STRING(1000)
        },
        today: {
            type: DataTypes.STRING(1000)
        },
        blockers: {
            type: DataTypes.STRING(1000)
        },
        goal: {
            type: DataTypes.STRING(1000)
        },
        monday: {
          type: DataTypes.BOOLEAN
        },
        tuesday: {
          type: DataTypes.BOOLEAN
        },
        wednesday: {
          type: DataTypes.BOOLEAN
        },
        thursday: {
          type: DataTypes.BOOLEAN
        },
        friday: {
          type: DataTypes.BOOLEAN
        }
    });

    return Standup;
};
