
function Trig_TeleGather_Conditions takes nothing returns boolean
    if ( not ( UnitHasBuffBJ(GetManipulatingUnit(), 'B00H') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_TeleGather_Actions takes nothing returns nothing
local unit a = GetManipulatingUnit()
local unit b = LoadUnitHandle( udg_GameHash, GetHandleId(a), StringHash("fire"))
local item i = GetManipulatedItem()
local real q = 120 // items other than list
local real r
if b != null then
    if (UnitHasBuffBJ(b, 'B00I')==false) then
        call UnitRemoveAbility( a, 'B00H' )
        call RemoveSavedHandle(udg_GameHash, GetHandleId(a), StringHash("fire"))
    else
        if(GetUnitTypeId(a) == UNIT_HERB_MASTER) or (GetUnitTypeId(a) == UNIT_RADAR_GATHERER) then
            set r = GetRandomReal(0, 100)
        elseif GetUnitTypeId(a) == UNIT_OMNIGATHERER then
            set r = GetRandomReal(0, 100)
        endif

        if(GetItemTypeId(i) == ITEM_BUTSU or GetItemTypeId(i) == ITEM_RIVER_ROOT or GetItemTypeId(i) == ITEM_RIVER_STEM or GetItemTypeId(i) == ITEM_BLUE_HERB or GetItemTypeId(i) == ITEM_ORANGE_HERB or GetItemTypeId(i) == ITEM_REFINED_POISON_SPEAR or GetItemTypeId(i) == ITEM_RIVER_ROOT) then
            if(GetUnitTypeId(a) == UNIT_HERB_MASTER or GetUnitTypeId(a) == UNIT_OMNIGATHERER) then
                set q=100
            else
                set q=-70 // 0% for Radar Gatherer
            endif
        endif

        if r < q then
            call SetItemPosition( i, GetUnitX(b), GetUnitY(b) )
        endif
    endif
else
    call UnitRemoveAbility( a, 'B00H' )
    call RemoveSavedHandle(udg_GameHash, GetHandleId(a), StringHash("fire"))
endif
set b = null
set a = null
set i = null
endfunction

//===========================================================================
function InitTrig_TeleGather takes nothing returns nothing
    set gg_trg_TeleGather = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_TeleGather, EVENT_PLAYER_UNIT_PICKUP_ITEM )
    call TriggerAddCondition( gg_trg_TeleGather, Condition( function Trig_TeleGather_Conditions ) )
    call TriggerAddAction( gg_trg_TeleGather, function Trig_TeleGather_Actions )
endfunction

//===========================================================================
