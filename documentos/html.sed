s;<table>;<table class="table">;g
s;BlogME;<span style="color:#2E4756">Blog</span><span style="color:#8AC142">me</span>;g

/<!--/s;<!--[^<]*\(</\?div[^>]*>\).*-->;\1;g

/<img .*title="[^"].*class=&quot/s; class=&quot\;\([^&]\+\)&quot\;";" class="\1";g
