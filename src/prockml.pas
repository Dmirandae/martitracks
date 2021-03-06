procedure kml0;
{ 
	modificado Susy jun 03 2010
	
	}


begin {incio kml0}

writeln(salida,'<?xml version="1.0"?><kml xmlns="http://earth.google.com/kml/2.1">');
writeln(salida,'<Document>');
writeln(salida,'<name>MST =T',uno,'</name>');
writeln(salida,'<description><![CDATA[<p>KML file generated by Marti tracks - PANtrack</p>');
writeln(salida,'<p>This is a test version.</p>]]></description>');

end; {fin kml0}

procedure cerrar_kml;

begin		
		writeln(salida);
		writeln(salida,'</Document>');
		writeln(salida,'</kml>');
		close(salida);
		if prekaos then writeln('kml closed');
end;

procedure trck2kml (contar : LongInt);

var
counter : LongInt;


tmp: string[8];

{ 
	modificado Susy jun 03 2010
	
	}

begin {trck2kml}
salidausada:= true;
if prekaos then 
	begin
	gotoxy(2,10);
	writeln('writing kml for');
	gotoxy(2,11);
	writeln(' species ',pTrazo[contar]^.especie);
	gotoxy(2,12);
	writeln(' number of segments ',pTrazo[contar]^.num_tramos);
	end;



writeln(salida,'<Style id="spstyle',contar,'">');
writeln(salida,'	<IconStyle>');
//sleep(100);
randomize;
write(salida,'		<color>ff');
tmp:=inttohex(random(16777215),6);
write(salida,tmp);
writeln(salida,'</color>');
writeln(salida,'		<Icon><href>http://maps.google.com/mapfiles/kml/paddle/wht-blank.png</href></Icon>');
writeln(salida,'	</IconStyle>');
writeln(salida,'	<LineStyle>');
randomize;
write(salida,'		<color>ff');

write(salida,tmp);

writeln(salida,'</color>');
writeln(salida,'		<width>4</width>');
writeln(salida,'	</LineStyle>');
writeln(salida,'</Style>');


writeln(salida,'<Folder>');
writeln(salida,'	<name>Track',contar, '</name>');
writeln(salida,'	<visibility>0</visibility>');
writeln(salida,'			<name>',pTrazo[contar]^.especie,' Track</name>');
writeln(salida,'			<description><![CDATA[<i>', pTrazo[contar]^.especie,'</i> track<br>pantrack id:',contar,']]></description>');
writeln(salida,'			<Placemark>');
writeln(salida,'				<name>',pTrazo[contar]^.especie,' MST</name>');
writeln(salida,'				<description><![CDATA[<i> species ', pTrazo[contar]^.especie,'</i> mst<br>long= ',pTrazo[contar]^.size:2:3,' corte ',corte:2:6 ,']]></description>');
writeln(salida,'				<styleUrl>#spstyle',contar,'</styleUrl>');
writeln(salida,'				<MultiGeometry>');

    for counter := 1 to pTrazo[contar]^.num_tramos do
    begin
writeln(salida,'			<LineString>');
writeln(salida,'						<tessellate>true</tessellate>');
writeln(salida,'						<altitudeMode>clampToGround</altitudeMode>');
writeln(salida,'						<coordinates>');

//writeln('i ',i,' j ',j,' N ',pTrazo[contar]^.num_tramos,' counter ',counter);

writeln(salida,'							',
pTrazo[contar]^.tramo[counter]^.Ncoord^.y:2:3,',',
pTrazo[contar]^.tramo[counter]^.Ncoord^.x:2:3,' ',
pTrazo[contar]^.tramo[counter]^.Scoord^.y:2:3,',',
pTrazo[contar]^.tramo[counter]^.Scoord^.x:2:3);




writeln(salida,'						</coordinates>');
writeln(salida,'					</LineString>');
if kaos3 then 
begin
//
writeln(pTrazo[contar]^.tramo[counter]^.Ncoord^.y
:2:2,',',
pTrazo[contar]^.tramo[counter]^.Ncoord^.x
:2:2,' ',
pTrazo[contar]^.tramo[counter]^.Scoord^.y
:2:2,',',
pTrazo[contar]^.tramo[counter]^.Scoord^.x
:2:2
);
end;


    end;


		writeln(salida,'				</MultiGeometry>');
		writeln(salida,'			</Placemark>');
		writeln(salida,'</Folder>');
		if prekaos then writeln(' kml written');
		
end; {trck2kml}


procedure ptos2kml (Puntos_escribir: tipopuntos; contar:longint);

var

contador1: LongInt;

tmp: string[8];


begin {escribir_puntos}


Puntos_escribir:=nuevos_puntos(Puntos_escribir);
salidausada:=true;

writeln(salida,'<Style id="spstyle',contar,'">');
writeln(salida,'	<IconStyle>');
//sleep(500);
randomize;
write(salida,'		<color>ff');
tmp:=inttohex(random(16777215),6);
write(salida,tmp);
writeln(salida,'</color>');
writeln(salida,'		<Icon><href>http://maps.google.com/mapfiles/kml/paddle/wht-blank.png</href></Icon>');
writeln(salida,'	</IconStyle>');
writeln(salida,'	<LineStyle>');
write(salida,'		<color>ff');

write(salida,tmp);

writeln(salida,'</color>');
writeln(salida,'		<width>4</width>');
writeln(salida,'	</LineStyle>');
writeln(salida,'</Style>');


writeln(salida,'<Folder>');
writeln(salida,'	<name>Node ',contar,'</name>');
writeln(salida,'	<visibility>0</visibility>');
writeln(salida,'    <Folder>');
writeln(salida,'			<name>Node ',contar,'</name>');
				
 for contador1:= 1 to Puntos_escribir^.numero do 
 	begin
writeln(salida,'			<Placemark>');
writeln(salida,'				<name>',contar,'node</name>');
writeln(salida,'				<description><![CDATA[ ]]></description>');
writeln(salida,'				<styleUrl>#spstyle',contar,'</styleUrl>');
    
writeln(salida,'				<Point>');
writeln(salida,'				   <extrude>0</extrude>');
writeln(salida,'						<altitudeMode>absolute</altitudeMode>');
writeln(salida,'						<coordinates>');

writeln(salida,Puntos_escribir^.coord[contador1]^.y:2:2,', ',Puntos_escribir^.coord[contador1]^.x:2:2);

writeln(salida,'						</coordinates>');
writeln(salida,'					</Point>');
writeln(salida,'		    	</Placemark>');

 		 
    end; {por punto}
        
		writeln(salida,'     </Folder>');
		
		writeln(salida,'</Folder>');
 	
			if prekaos then writeln(' points ',contar,' written');
end; {ptos2kml}
