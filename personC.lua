txd = engineLoadTXD("skin.txd")
engineImportTXD(txd, 9)
dff = engineLoadDFF("skin.dff", 9)
engineReplaceModel(dff, 9)

clothesTable = {
    ["biquini"] = {
        {"Bikini/Biquini1.png", "Biquini"}, -- 1 remove
        {"Bikini/Biquini2.png", "Biquini"}, -- 2 remove
        {"Bikini/Biquini3.png", "Biquini"}, -- 3 remove
    },
    ["blusa"] = {
        {"base.png", "Blusa20"}, -- 1 remove
        {"Blusa/Blusa1.png", "Blusa20"}, -- 2 add
        {"Blusa/Blusa2.png", "Blusa20"}, -- 3 add
        {"Blusa/Blusa3.png", "Blusa20"}, -- 4 add
        {"Blusa/Blusa4.png", "Blusa20"}, -- 5 add
        {"Blusa/Blusa5.png", "Blusa20"}, -- 6 add
        {"Blusa/Blusa6.png", "Blusa20"}, -- 7 add
        {"Blusa2/Blusa1.png", "Blusa20"}, -- 8 add
    },
    ["calca"] = {
        {"base.png", "Calca"}, -- 1 remove
        {"Calca/Calca1.png", "Calca"}, -- 2 add
        {"Calca/Calca2.png", "Calca"}, -- 3 add
        {"Calca/Calca3.png", "Calca"}, -- 4 add
        {"Calca/Calca4.png", "Calca"}, -- 5 add
        {"Calca/Calca5.png", "Calca"}, -- 6 add
        {"Calca/Calca6.png", "Calca"}, -- 7 add
        {"Calca/Calca7.png", "Calca"}, -- 8 add
        {"Calca/Calca8.png", "Calca"}, -- 9 add
        {"Calca/Calca9.png", "Calca"}, -- 10 add
        {"Calca/Calca10.png", "Calca"}, -- 11 add
        {"Calca/Calca11.png", "Calca"}, -- 12 add
    },
    ["moletom"] = {
        {"base.png", "Moletom"}, -- 1 remove
        {"Moletom/Moletom1.png", "Moletom"}, -- 2 add
        {"Moletom/Moletom2.png", "Moletom"}, -- 3 add
        {"Moletom/Moletom3.png", "Moletom"}, -- 4 add
        {"Moletom/Moletom4.png", "Moletom"}, -- 5 add
        {"Moletom/Moletom5.png", "Moletom"}, -- 6 add
        {"Moletom/Moletom6.png", "Moletom"}, -- 7 add
        {"Moletom/Moletom7.png", "Moletom"}, -- 8 add
        {"Moletom/Moletom8.png", "Moletom"}, -- 9 add
        {"Moletom/Moletom9.png", "Moletom"}, -- 10 add
    },
}
--[[
CorpoTable = {
    {"base.png", "1"},
    {"Corpo/Body.png", "Body"}, --1
    {"Corpo/Bracos.png", "Bracos"}, --2
    {"Corpo/Face1.png", "Face1"}, --3
    {"Corpo/Maos.png", "Maos"}, --4
    {"Corpo/Pernas.png", "Pernas"}, --5
    {"Corpo/Pes.png", "Pes"}, --6
    {"Corpo/Tornozelo.png", "Tornozelo"}, --7
    {"Bikini/Biquini.png", "Biquini"}, --8
    {"Bikini/Biquini21.png", "Biquinii"}, --9
}
]]
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
    function()
        for i,v in ipairs(CorpoTable) do
            shader1 = dxCreateShader( "shader.fx", 0, 0, false, "ped" )
            local texture = dxCreateTexture(v[1])
            engineApplyShaderToWorldTexture( shader1, v[2], localPlayer )
            dxSetShaderValue(shader1, "gTexture", texture)
        end
    end
)

addCommandHandler("setmodel",
    function(cmd, category, modelId)
        for i,v in ipairs(clothesTable[category]) do
            if (i) == tonumber(modelId) then
                local shader = dxCreateShader( "shader.fx", 0, 0, false, "ped" )
                local texture = dxCreateTexture(v[1])
                engineApplyShaderToWorldTexture( shader, v[2], localPlayer )
                dxSetShaderValue(shader, "gTexture", texture)
                if category == "calca" then
                    if tonumber(modelId) ~= 1 then
                        local textureRemove = dxCreateTexture("base.png")
                        local shaderRemove = dxCreateShader( "shader.fx", 0, 0, false, "ped" )
                        engineApplyShaderToWorldTexture( shaderRemove, "Biquinii", localPlayer )
                        engineApplyShaderToWorldTexture( shaderRemove, "Pernas", localPlayer )
                        dxSetShaderValue(shaderRemove, "gTexture", textureRemove)
                    else
                        for i,v in ipairs(CorpoTable) do
                            if i==5 or i==9 then
                                local shader = dxCreateShader( "shader.fx", 0, 0, false, "ped" )
                                local texture = dxCreateTexture(v[1])
                                setElementAlpha(texture, 255)
                                engineApplyShaderToWorldTexture( shader, v[2], localPlayer )
                                dxSetShaderValue(shader, "gTexture", texture)
                            end
                        end
                    end
                elseif category == "moletom" then
                    if tonumber(modelId) ~= 1 then
                        local textureRemove = dxCreateTexture("base.png")
                        local shaderRemove = dxCreateShader( "shader.fx", 0, 0, false, "ped" )
                        engineApplyShaderToWorldTexture( shaderRemove, "Body", localPlayer )
                        engineApplyShaderToWorldTexture( shaderRemove, "Bracos", localPlayer )
                        engineApplyShaderToWorldTexture( shaderRemove, "Biquini", localPlayer )
                        dxSetShaderValue(shaderRemove, "gTexture", textureRemove)
                    else
                        for i,v in ipairs(CorpoTable) do
                            if i==1 or i==2 or i==8 then
                                local shader = dxCreateShader( "shader.fx", 0, 0, false, "ped" )
                                local texture = dxCreateTexture(v[1])
                                setElementAlpha(texture, 255)
                                engineApplyShaderToWorldTexture( shader, v[2], localPlayer )
                                dxSetShaderValue(shader, "gTexture", texture)
                            end
                        end
                    end                   
                end
            end
        end
    end
)
