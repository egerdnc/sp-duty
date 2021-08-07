function buildList()
      exports["sp-target"]:AddTargetPoint({
        name = "PoliceDuty",
        label = "Polis Departmanı",
        icon = "fas fa-clipboard-list",
        point = vector3(441.79, -982.07, 30.69),
        interactDist = 2.5,
        onInteract = onInteract,
        options = {
          {
            name = "mesai",
            label = "Mesai Başla / Bitir"
          }    
        }
      })
end

function onInteract()
    TriggerEvent("sp-duty:sign")
end
