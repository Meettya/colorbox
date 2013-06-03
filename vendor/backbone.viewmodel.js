// Generated by clinch 0.3.5
(function() {
  'use strict';
  
      
var dependencies, name_resolver, require, sources, _this = this;

name_resolver = function(parent, name) {
  if (dependencies[parent] == null) {
    throw Error("no dependencies list for parent |" + parent + "|");
  }
  if (dependencies[parent][name] == null) {
    throw Error("no one module resolved, name - |" + name + "|, parent - |" + parent + "|");
  }
  return dependencies[parent][name];
};
require = function(name, parent) {
  var exports, module, module_source, resolved_name, _ref;
  if (!(module_source = sources[name])) {
    resolved_name = name_resolver(parent, name);
    if (!(module_source = sources[resolved_name])) {
      throw Error("can`t find module source code: original_name - |" + name + "|, resolved_name - |" + resolved_name + "|");
    }
  }
  module_source.call(_this,exports = {}, module = {}, function(mod_name) {
    return require(mod_name, resolved_name != null ? resolved_name : name);
  });
  return (_ref = module.exports) != null ? _ref : exports;
};
  dependencies = {"1093359753":{"backbone":3339915730,"lodash":1154215551}};
  sources = {
"1093359753": function(exports, module, require) {
// /Users/meettya/github/backbone.viewmodel/src/backbone.viewmodel.coffee 
/*
This is Backbone.ViewModel implementation with attributes mapping and synchronization on demand.
*/

var Backbone, _,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Backbone = require('backbone');

_ = require('lodash');

module.exports = Backbone.ViewModel = (function(_super) {
  __extends(ViewModel, _super);

  function ViewModel(data_in, constructor_attrs, _options_) {
    if (constructor_attrs == null) {
      constructor_attrs = {};
    }
    this._options_ = _options_ != null ? _options_ : {};
    this.update = __bind(this.update, this);
    if (!data_in) {
      throw Error("model or raw data required, but got |" + data_in + "|");
    }
    this.model = data_in instanceof Backbone.Model ? data_in : this._createModelFromRawData(data_in);
    ViewModel.__super__.constructor.call(this, constructor_attrs);
    this._mapping_dictionary_ = this._buildMappingDictionary() || {};
    if (this._options_.autoupdate || this.autoupdate) {
      this.model.on('change', this.update);
    }
    this.update();
  }

  /*
  Public API for synchronization VM with Model
  */


  ViewModel.prototype.update = function() {
    return this._synchronizeWithModel();
  };

  /*
  This method will synchronize ViewModel data with Model data
  NB we are can't to do lazy re-load with @model.changedAttributes
  because keys in _mapping_dictionary_ not one-to-one mapped to model properties
  */


  ViewModel.prototype._synchronizeWithModel = function() {
    var data_source_fn, self_attr, _ref, _results;

    _ref = this._mapping_dictionary_;
    _results = [];
    for (self_attr in _ref) {
      data_source_fn = _ref[self_attr];
      _results.push(this.set(self_attr, _.cloneDeep(data_source_fn())));
    }
    return _results;
  };

  /*
  This method build mapping dictionary with pre-fired function
  */


  ViewModel.prototype._buildMappingDictionary = function() {
    var data_source, res_obj, self_attr, _fn, _ref,
      _this = this;

    if (this.mapping == null) {
      return null;
    }
    res_obj = {};
    _ref = this.mapping;
    _fn = function(self_attr, data_source) {
      return res_obj[self_attr] = (function() {
        var _this = this;

        if ((this[data_source] != null) && _.isFunction(this[data_source])) {
          return function() {
            return _this[data_source]();
          };
        } else if (this.model.has(data_source)) {
          return function() {
            return _this.model.get(data_source);
          };
        } else {
          throw Error("can`t map |" + self_attr + "| to |" + data_source + "| - no self function neither model property");
        }
      }).call(_this);
    };
    for (self_attr in _ref) {
      data_source = _ref[self_attr];
      _fn(self_attr, data_source);
      null;
    }
    return res_obj;
  };

  /*
  This method will create model if we are got raw data
  */


  ViewModel.prototype._createModelFromRawData = function(raw_data) {
    var constructor;

    constructor = this.constructor.prototype.model == null ? Backbone.Model : this.constructor.prototype.model;
    return new constructor(raw_data);
  };

  return ViewModel;

})(Backbone.Model);
},
"1154215551": function(exports, module, require) {
// /Users/meettya/github/backbone.viewmodel/web_modules/lodash.coffee 
/*
This is lodash shim
*/
module.exports = this._;
},
"3339915730": function(exports, module, require) {
// /Users/meettya/github/backbone.viewmodel/web_modules/backbone.coffee 
/*
This is Backbone shim
*/
module.exports = this.Backbone;
}};
/* bundle export */
this.Backbone.Viewmodel = require(1093359753)
}).call(this);