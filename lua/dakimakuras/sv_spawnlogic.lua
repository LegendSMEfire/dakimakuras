resource.AddFile("materials/models/dakimakura/dakifront.vtf")
resource.AddFile("materials/models/dakimakura/dakiback.vtf")
resource.AddFile("models/dakimakura/daki.mdl")

net.Receive("dakimakuras-net", function( Len, Player )
	local CanSpawn = hook.Run("PlayerSpawnSENT", Player, "prop_dakimakura")
	local EyeTrace = Player:GetEyeTrace()
	
	if( CanSpawn == nil or CanSpawn == true )then
		local Front, Back = net.ReadString(), net.ReadString()
		local Daki = ents.Create("prop_dakimakura")
		Daki:SetPos( EyeTrace.HitPos + EyeTrace.HitNormal * 50 )
		Daki:SetDegenerate( Player:SteamID() )
		Daki:Spawn()
		Daki:PhysWake()
		
		timer.Simple( .05, function()
			Daki:SetFrontImage( Front )
			Daki:SetBackImage( Back )
		end)
		
		undo.Create("Dakimakura")
			undo.SetCustomUndoText("Undone Dakimakura")
			undo.SetPlayer( Player )
			undo.AddEntity( Daki )
		undo.Finish()
	end
end)