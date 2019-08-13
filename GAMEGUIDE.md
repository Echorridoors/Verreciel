## Loiqe

Start capsule with battery
Start capsule with battery 1

### 0. Tutorial

Route cell to thruster
Undock with thruster
Accelerate with Thruster
Wait for arrival
Route [currency1] to cargo
Route cargo to console
Undock with thruster
Wait for arrival

### 1. Fragments
Route [currency1] to verreciel.cargo
Route [currency1] to trade table
Route [valenPortalFragment1] to verreciel.cargo

### 2. Radar
Select satellite on radar
Route Radar to Pilot

### 3. Portal
Aquire [valenPortalFragment1]
Aquire [valenPortalFragment2]
Combine fragments

## 4. Transit
Route [valenPortalKey] to Portal
Align pilot to portal
Power Thruster with portal

## Valen

### 5. Valen
Collect [record1]
Collect second cell
Collect [currency2]
Install radio

### 6. Record
Install cell in battery
Power radio
Route record to radio

### 7. Hatch
Collect Waste
Route waste to hatch
Jetison Waste

### 8. Currencies
Collect [loiqePortalKey]
Aquire [currency2]
Aquire [currency1]
Combine currencies

## Senni

## 9. Senni
Aquire [currency4]
Trade [currency4] for [senniPortalKey]

### 10. Map
Collect [map1]
Collect [currency3]
Install map

### 11. Fog
Power Map in battery
Route fog to map
Collect third cell
Install cell in battery

### 12. Helmet
Route map to helmet
Collect [usulPortalFragment1]
Collect [usulPortalFragment2]
Combine fragments

## Usul 

### MISSION: Usul
Install shield
Create [endPortalKeyFragment1]
Create [endPortalKeyFragment2]
Combine fragments

### MISSION: Shield
Collect [map2]
Route [map2] to map
Collect [shield]
Route [shield] to shield
Power Shield in battery

### MISSION: mechanism
Extinguish the sun
Extinguish the sun
Extinguish the sun
Extinguish the sun

## MISSION: At the close
Witness

## MISSION: End
Stop

## Currencies

```
metal(cur1) --+
              > meseta --+
sutal(cur2) --+          > icon
              > suveta --+
vital(cur3) --+
```               

### Harvest Points

- Loiqe: metal
- Valen: sutal
- Senni: vital

### Old Currencies

- metal(alta)
- sutal(ikov)
- vital(eral)
- meseta(alitov)
- suveta(ikeral)
- icon(echo)

Mission(14), create cur4.

## Origins & References

- The Horadric location, comes from diablo.
- the Meseta currency, comes from phantasy star online.

## Notes

It's weird when the helmet gives old quest instructions for the current mission
  I don't mean in response to mistakes, I mean when the player's doing the right thing

Routing the helmet into the console could allow the user to type in commands.

-------

beacons
  One in south valen, one in south usul
  starts red, pressing button turns it grey
    takes three times as long as harvest
    50% chance of no result
  Returns cipher
  cipher 1 & cipher 2 = key to Nevic

Nevic
  South of loiqe
  Not sure what to do there though
  Maybe work enigma into it?
  Green space, black stars
  Black approachable sun
    It’s always night$under the$ultraviolet sun
    Give LocationStar another parameter
