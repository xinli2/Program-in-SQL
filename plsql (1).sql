

create or replace procedure insertToMovie(v_movieid in movie.movieid%type, v_title in movie.title%type, v_year in movie.year%type, v_score in movie.score%type, v_votes in movie.votes%type)
AS
	v_count integer;
begin 
	select count(*) into v_count 
	from movie
	where year = v_year;
	
	if v_count<4 then 
		insert into movie(movieid, title, year, score, votes) values(v_movieid , v_title, v_year, v_score, v_votes);
	
	end if;


end;





create or replace procedure insertToCasting(v_movieid in casting.movieid%type, v_actorid in casting.actorid%type, v_ordinal casting.ordinal%type)
as
	v_ordinal_num integer default 0;
	v_actor_num integer default 0;
begin 
	select count(*) into v_ordinal_num
	from casting
	where movieid= v_movieid and ordinal= v_ordinal
	;
	
	select count(*) into v_actor_num
	from casting
	where actorid = v_actorid
	;
	
	if v_ordinal_num<1 and v_actor_num<3 then 
		 insert into casting(movieid,actorid, ordinal) values(v_movieid,v_actorid, v_ordinal);
	
	end if;
	
	
end;




alter table Actor add column RecentDate date;


create or replace trigger Casting_trigger before insert on actor
for each row
begin 
	UPDATE Actor
	SET RecentDate = SYSDATE 
	where ActorID = :new.ActorID;

end;



