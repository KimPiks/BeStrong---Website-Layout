<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="site">
        <html>
          <head>
            <title>Kamil Prorok 201095</title>
            <link href="styles.css" rel="stylesheet"/>
          </head>
          <body>
            <xsl:call-template name="training_plan"/>
            <xsl:apply-templates select="exercises"/>
            <xsl:apply-templates select="diet/macro_list"/>
          </body>
        </html>
    </xsl:template>

    <xsl:template name="training_plan">
      <xsl:variable name="plan">
        <tr>
          <td><xsl:value-of select="//site/training_plans/training_plan[1]/@plan_type"/></td>
          <td><xsl:value-of select="count(//site/training_plans/training_plan[1]/day[@rest_day='false'])"/></td>
        </tr>
        <tr>
          <td><xsl:value-of select="//site/training_plans/training_plan[2]/@plan_type"/></td>
          <td><xsl:value-of select="count(//site/training_plans/training_plan[2]/day[@rest_day='false'])"/></td>
        </tr>
      </xsl:variable>

      <h2>Informacje o planach treningowych</h2>
      <div>
        <table>
          <tr>
            <th>Plan</th>
            <th>Training days</th>
          </tr>
          <xsl:copy-of select="$plan" />
        </table>
      </div>
    </xsl:template>

    <xsl:template match="exercises">
      <h2>Ćwiczenia</h2>
      <xsl:for-each select="exercise">
        <div style="border: 1px solid black;">
          <p>
          <xsl:number value="position()" format="a)"/>
          Name: <xsl:value-of select="name"/>
          <xsl:if test="@risky != 'low'">
            <xsl:apply-templates select="."/>
          </xsl:if>
          </p>
          <p>Description: <xsl:apply-templates select="description"/></p>
          <p>
          Links:</p>
          <p>
          <xsl:choose>
            <xsl:when test="links">
              <xsl:apply-templates select="links"/>
            </xsl:when>
            <xsl:otherwise>
              No
            </xsl:otherwise>
          </xsl:choose>
          </p>
          <p>
            Image:
            <xsl:choose>
              <xsl:when test="image">
                <br/><xsl:apply-templates select="image"/>
              </xsl:when>
              <xsl:otherwise>
                No
              </xsl:otherwise>
            </xsl:choose>
          </p>
          <p>Body parts: <xsl:apply-templates select="engagement"/></p>
          <p>Equipment needed (many variants?): <xsl:apply-templates select="equipment_needed"/></p>
          <p>Rep ranges: <xsl:apply-templates select="rep_ranges" /> </p>
        </div>
      </xsl:for-each>
    </xsl:template>

    <xsl:template match="exercise[@risky!='low']">
      <xsl:choose>
        <xsl:when test="@risky = 'high'">
          *Very risky
        </xsl:when>
        <xsl:otherwise>
          *Risky
        </xsl:otherwise>
      </xsl:choose>
    </xsl:template>

    <xsl:template match="description">
      <xsl:value-of select="."/>
      <a href="{link/@url}"><xsl:value-of select="link/@url"/></a>
    </xsl:template>

    <xsl:template match="links">
      <a href="{link/@url}">
        <xsl:value-of select="link/@url"/>
      </a><br/>
    </xsl:template>

    <xsl:template match="image">
      <xsl:if test=".">
        <img src="{@url}" style="width:200px;"/>
      </xsl:if>
    </xsl:template>

    <xsl:template match="engagement">
      <b><xsl:value-of select="translate(., 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/></b>
    </xsl:template>

    <xsl:template match="equipment_needed">
      <xsl:choose>
        <xsl:when test="@optional = 'true'">
          Yes
        </xsl:when>
        <xsl:otherwise>
          No
        </xsl:otherwise>
      </xsl:choose>
    </xsl:template>

    <xsl:template match="rep_ranges">
      <xsl:variable name="count" select="string-length(.) - string-length(translate(., ' ', '')) + 1"/>
      <xsl:value-of select="."/>
      <p>Possibilities: <xsl:value-of select="$count"/></p>
    </xsl:template>

    <xsl:template match="diet/macro_list">
      <h2>Składniki diety</h2>
      <div>
        <table>
          <tr>
            <th>Number</th>
            <th>Element</th>
            <th>Min amount</th>
            <th>Max amount</th>
          </tr>
          <xsl:for-each select="macro_element">
            <xsl:sort select="@element"/>
            <tr>
              <td><xsl:number value="position()" format="1"/>.</td>
              <td><xsl:value-of select="@element"/></td>
              <td><xsl:value-of select='format-number(@min_amount, "#.00")'/></td>
              <td><xsl:value-of select='format-number(@max_amount, "#.0")'/></td>
            </tr>
          </xsl:for-each>
        </table>
      </div>
    </xsl:template>

</xsl:stylesheet>