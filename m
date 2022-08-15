Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE0F592708
	for <lists+linux-raid@lfdr.de>; Mon, 15 Aug 2022 02:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiHOANz (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 14 Aug 2022 20:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHOANz (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 14 Aug 2022 20:13:55 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4761147D
        for <linux-raid@vger.kernel.org>; Sun, 14 Aug 2022 17:13:54 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 53-20020a9d0838000000b006371d896343so4541799oty.10
        for <linux-raid@vger.kernel.org>; Sun, 14 Aug 2022 17:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=t32Qb/mkYhtxsCn4y+TW2WtYKhq2OTr5K6X7UMsrQBA=;
        b=XItww1LI9n6F/9IzYjQdtKiQUGNnYFjFntpucLGsLynYH8ErJqRRfgRrP2nKGq5jSz
         czkf/Ks+VnXS+Qjo7+xIw6m5wIhlvo+wQM9/xp7zPhrUd8JTf6ZTA3WJnyRlG3m3asFr
         skaPC99N5ivMARvWqBCQRM79uzCYEyqqsqu4LoKbEQy8fi0hFnnZ63AVfTubPv5SQhzl
         gdBoc1NUJ+q9lY4VOreeLofBes5ZnJSpbpZoCa6lGmflihGCKfpZSvFCkR3v6B+eGbzA
         7x6FP6n1ZK2Im/RVj1ux8kPvZqCqLE3O1hkTYTuBLcOwepPvD8AEd4MpKbwFr7A8Ktl3
         dmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=t32Qb/mkYhtxsCn4y+TW2WtYKhq2OTr5K6X7UMsrQBA=;
        b=8Dl8wiuZhtTAV5CwUbD2CJbtm+CdKZWAaf+lCSS3pLK79WcllVBTMQqxVpltTN8Oj/
         USfGffpMP1SWW9LwVEsfPZEzQ22AG6Uf0+R+caTrkSJFvNJfH9D+ZbHUuwsFknuTQ0ry
         VoMiYUqcFru89qULRgeWvAjWRV9NWiyHv/GOgMQRfQn8XlfsKMimYAsJ0sos+x8M8FOO
         Ur+RXijj3KhefiVGtZpwjceTlMw5qvqnDKRepx4MmOQrodgYEWk2KllDJywOQToMcuJp
         sjKt+tF/65zw5B0F6EYyBnPrUPPUtMRe+OyZGtdziJvgO8a/4qt+FAdP20d+nWv1gbTe
         Iplg==
X-Gm-Message-State: ACgBeo05lsSvER4SK6szgjaOyIhYzYn9Oc1b6Tm61kWGACpMM427PENU
        MyVWpSuHmkJZFqUjR7mbJRZukQ4e5FC1xbtkavMVzT9WDLE=
X-Google-Smtp-Source: AA6agR7/BCVgQTNH/mM7UlNuKlde/wL2/XPT2CYrzCZUGqGbvnSzj3MC21MwYnSWibU0sqwLySoTNZ5Zv5Uuo9Wfsxg=
X-Received: by 2002:a05:6830:1bc4:b0:636:e925:c3b6 with SMTP id
 v4-20020a0568301bc400b00636e925c3b6mr5293648ota.86.1660522432871; Sun, 14 Aug
 2022 17:13:52 -0700 (PDT)
MIME-Version: 1.0
From:   "David F." <df7729@gmail.com>
Date:   Sun, 14 Aug 2022 17:13:42 -0700
Message-ID: <CAGRSmLsNjss5snncB0LfWmKnZUQ9Lfoth76FWf5w3d0WtgDrAg@mail.gmail.com>
Subject: Attempt to assemble RAID times out and drives go busy?
To:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

If I start kernel 5.15.60 with parameter "nodmraid" then attempt to
run the script below, it will fail (attempts to assemble but it will
timeout and sda/sdb become busy).  Yet, loading through the udev rules
the raid is created okay.  Although dmraid overtakes the mdadm.

Here's the script that always worked until updating to both 5.15.x and
all the various libraries and utilities.

#! /bin/bash

if [ ! -e /proc/mdstat ]; then
    echo "Software RAID drivers not loaded"
    exit 0
fi

if [ ! -e /etc/mdadm/mdadm.conf-default ]; then
    echo "Default config file not found in /etc/mdadm"
    exit 0
else
    cp /etc/mdadm/mdadm.conf-default /etc/mdadm/mdadm.conf
fi

mdadm --examine --scan >> /etc/mdadm/mdadm.conf
mdadm --assemble --scan --no-degraded -v
