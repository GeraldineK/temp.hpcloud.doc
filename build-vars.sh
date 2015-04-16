echo "Setting environment variables…"

# this assumes you've already exported XEP_HOME (if you're using XEP)

# ugly parent directory hacks to avoid breaking other build stuff:
export DITA_HOME="`pwd`/tools/DITA-OT"
export DITAC_HOME="`pwd`/tools/ditac/ditac-2_2_3"
export DOC_HOME="`pwd`"
export PRODUCT_DIR="./products"
export ANT_HOME="$DITA_HOME/tools/ant"
echo DITA_HOME IS $DITA_HOME
echo DOC_HOME is $DOC_HOME
echo PRODUCT_DIR is $PRODUCT_DIR
echo ANT_HOME is $ANT_HOME

CUR_PWD="`pwd`"

# Get the absolute path of DITAOT's home directory
cd "$DITA_HOME"
DITA_DIR="`pwd`"
echo DITA_DIR is $DITA_DIR
cd "$CUR_PWD"

# Make sure ant binary is executable
if [ -f "$DITA_DIR"/tools/ant/bin/ant ] && [ ! -x "$DITA_DIR"/tools/ant/bin/ant ]; then
echo "*** chmoding ant binary so it's executable ***"
chmod +x "$DITA_DIR"/tools/ant/bin/ant
fi

echo "*** Setting ant environment variables ***"
export ANT_OPTS="-Xmx512m $ANT_OPTS"
export ANT_OPTS="$ANT_OPTS -Djavax.xml.transform.TransformerFactory=net.sf.saxon.TransformerFactoryImpl"
#export ANT_HOME="$DITA_DIR"/tools/ant
#export DOC_VERSION_NUMBER=$(sed -n '/shortversionnumber">/ s/[^<]*<p><ph[^>]*>\([^<]*\).*/\1/p' ./shared/conrefs.dita)
#echo "  DOC VERSION NUMBER: " $DOC_VERSION_NUMBER

echo "*** Adding project-specific version of ant to path ***"
export PATH="$DITA_DIR"/tools/ant/bin:"$PATH"
echo " DITA ANT PATH is " $DITA_DIR "+/tools/ant/bin"

echo "*** Adding new CLASSPATH items ***"
# NEW_CLASSPATH="$DITA_DIR/lib/saxon/saxon9.jar:$DITA_DIR/lib/saxon/saxon9-dom.jar:$DITA_DIR/lib:$DITA_DIR/lib/dost.jar:$DITA_DIR/lib/commons-codec-1.4.jar:$DITA_DIR/lib/resolver.jar:$DITA_DIR/lib/icu4j.jar"

NEW_CLASSPATH="$DITA_DIR/lib/dost.jar"
NEW_CLASSPATH="$DITA_DIR/lib:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/commons-codec-1.4.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/resolver.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/icu4j.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/xercesImpl.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/xml-apis.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/saxon/saxon9.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/saxon/saxon9-dom.jar:$NEW_CLASSPATH"
if test -n "$CLASSPATH"; then
  export CLASSPATH="$NEW_CLASSPATH":"$CLASSPATH"
else
  export CLASSPATH="$NEW_CLASSPATH"
fi


#check to see if classpath already exists - if so, append our new values
if test -n "$CLASSPATH"
then
export CLASSPATH="$NEW_CLASSPATH":"$CLASSPATH"
else
export CLASSPATH="$NEW_CLASSPATH"
fi
 

