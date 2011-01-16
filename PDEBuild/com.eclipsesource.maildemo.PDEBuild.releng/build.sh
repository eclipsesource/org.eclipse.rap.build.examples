#!/bin/bash
#
###############################################################################
# Copyright (c) 2011 EclipseSource and others.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
#
# Contributors:
#     EclipseSource - initial API and implementation
###############################################################################
#
#
# This script is used to build a RAP Application using PDE build.

runtimeDir=
targetDir=
builder=$(pwd)

#Reading the command line arguments
for i
do
  case "$i" in
    --targetDir|-c) shift; targetDir=$1; shift;;
    --runtimeDir|-d) shift; runtimeDir=$1; shift;;
  esac
done

# Show informations
echo "Starting build with the following settings:"
echo "  Runtime Inst.:             $runtimeDir"
echo "  Target Platform Inst.:     $targetDir"
echo "  Builder:                   $builder"
echo ""

# Find PDE build
pdeBuild=`ls -1 $runtimeDir/plugins | grep pde.build_ | tail -n 1`
echo "Using PDE Build: $pdeBuild"

# Find Equinox launcher
launcher=$runtimeDir/plugins/`ls -1 $runtimeDir/plugins | grep launcher_ | tail -n 1`
echo "Using Equinox launcher: $launcher"

java -cp $launcher org.eclipse.core.launcher.Main \
    -application org.eclipse.ant.core.antRunner \
    -buildfile "$runtimeDir/plugins/$pdeBuild/scripts/build.xml" \
    -Dbuilder="$builder" \
    -DbuildId=`date +%Y%m%d-%H%M` \
    -DbaseLocation="$targetDir" \
    -Dfile.encoding=UTF-8 \
    