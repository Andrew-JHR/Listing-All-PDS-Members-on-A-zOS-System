 /* rexx */                                                             01250000
 do forever   /* loop for all recs of input file */                     01260000
  "execio 1 diskr filein"                                               01270000
      if rc \= 0  then                                                  01280000
        do                                                              01290000
         if rc =2 then leave                                            01300000
         else                                                           01310000
          do                                                            01320000
           say execname '"EXECIO DISKR" Exit=' rc                       01330000
          end                                                           01340000
        end                                                             01350000
   pull rec                                                             01360000
   dsn = substr(rec,2,44)                                               01370000
   if dsn = '---------------DATA SET NAME----------------' then         01380000
     do                                                                 01390000
      "execio 1 diskr filein"                                           01400000
      pull rec                                                          01410000
      parse var rec   dsn vol seqno datec datee dater ext ,             01420000
                     dsorg rest                                         01430000
      rest =space(rest)                                                 01440000
      if words(rest) > 3 then                                           01450000
       do                                                               01460000
        recfm = word(rest,1) || word(rest,2)                            01470000
        blksize = word(rest,4)                                          01480000
       end                                                              01490000
      else                                                              01500000
       do                                                               01510000
        recfm = word(rest,1)                                            01520000
        blksize = word(rest,3)                                          01530000
       end                                                              01540000
      "execio 1 diskr filein"                                           01550000
      pull rec                                                          01560000
      "execio 1 diskr filein"                                           01570000
      pull rec                                                          01580000
      lrecl = space(substr(rec,9,8))                                    01590000
                                                                        01590100
      /* mark any omvs files below */                                   01590200
      if blksize = 0 then                                               01595001
         dsorg = 'HF'                                                   01596000
      /* mmit any omvs files above */                                   01596100
                                                                        01597000
      queue left(dsn,44) ,                                              01600000
            || ',' || vol ,                                             01610000
            || ',' || right(dsorg,2) ,                                  01610100
            || ',' || right(dater,8) ,                                  01610200
            || ',' || right(datec,8),                                   01620000
            || ',' || left(recfm,3) ,                                   01640000
            || ',' || right(blksize,5) ,                                01650000
            || ',' || right(space(lrecl),5) || ','                      01660000
      "execio 1 diskw fileou"                                           01670000
     end                                                                01680000
 end /* end of do forever */                                            01690000
                                                                        01700000
 "execio 0 diskr filein (finis"                                         01710000
 "execio 0 diskw fileou (finis"                                         01720000
                                                                        01730000
 exit 0                                                                 01740000
