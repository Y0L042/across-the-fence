/*
    File: fn_zombie_canSee.sqf
    Author:
    Date: 2025-10-20
    Last Update: 2025-10-20
    Public: No

    Description:
        No description added yet.

    Parameter(s):
        N/A

    Returns:
        Something [BOOL]

    Example(s):
        [parameter] call vgm_X_fnc_component_myFunction
 */

params ["_zombie", "_target", "_range"];

if (isNull objectParent _target) exitWith {
  private _dist = _zombie distance _target;

  if ([_zombie, _target] call BIS_fnc_isInFrontOf) then {
    _target isFlashlightOn (currentWeapon _target) ||
    {
      private _targetEyepos = eyepos _target;
      /*
      private _visibleRange = switch (stance _target) do {
         case "CROUCH": {_range * 0.75};
         case "PRONE": {_range * 0.4};
         default {_range};
      };
      */
      private _visibleRange = _range;

      _dist < _visibleRange &&
      {_targetEyepos select 2 > -0.2} &&
      {[_zombie, "IFIRE", _target] checkVisibility [eyepos _zombie, _targetEyepos] > 0.2};
    };
  } else {
    (abs (speed _target) > 6 && _dist < 6);
  };
};

isEngineOn (vehicle _target) || {[_zombie, vehicle _target] call BIS_fnc_isInFrontOf}
