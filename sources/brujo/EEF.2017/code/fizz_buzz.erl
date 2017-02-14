-module(fizz_buzz).

-export [up_to/1].
-export [init/1].

up_to(Number) ->
  try gen_server:start(?MODULE, Number, []) of
    {ok, _Pid} -> ok;
    {error, not_number} ->
      io:format("Not a number ~p~n", [Number])
  catch
    _:Exception ->
      io:format("Couldn't process ~p: ~p~n", [Number, Exception])
  end.

init(Number) when is_number(Number) ->
  up_to(1, Number),
  {ok, Number};
init(_NotNumber) ->
  {stop, not_number}.

up_to(I, Top) when Top >= I ->
  I rem 3 == 0 andalso io:format("fizz"),
  [io:format("buzz") || I rem 5 == 0],
  I rem 3 /= 0 andalso [io:format("~p", [I]) || I rem 5 /= 0],
  io:format(" "),
  up_to(I + 1, Top);
up_to(I, Top) when Top < I ->
  io:format("~n").
