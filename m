Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35AE0C19BE
	for <lists+linux-raid@lfdr.de>; Mon, 30 Sep 2019 00:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbfI2Wyy (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 29 Sep 2019 18:54:54 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:55459 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728755AbfI2Wyy (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 29 Sep 2019 18:54:54 -0400
Received: by mail-wm1-f50.google.com with SMTP id a6so11259724wma.5
        for <linux-raid@vger.kernel.org>; Sun, 29 Sep 2019 15:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=DITB8TDqsPAGCEr6ydxFSW0ZRx1iCX6e3txUM+1mNSE=;
        b=tdP77wUHQvfk3h7BUjZFmPePJgRDPojV6jrAeiw13M7wjFitKQ+ehM/A7KbyAtVBtk
         W5PVYcY5G/J/cBrh1F8WCvd+k/62nGtDzEPHjhCNfpQDAz2PDpr6FHj0acsjqcAE+OMJ
         4J9aDVcCs6RQN6sil7/5BT9n4i3eLTCUSkRRCuuGdvChIN0GueQ4BTqO+SNDgdP3TxUe
         7z0s42Zd0I3tyNbfUOknDFZtGKJcKvASAoSA2xbW+yFRc8ghyMQ1uUunswo67zEntqEm
         l6csuhytLWYuWSoFFmuI4jSb4LTemGEVHk+xYC4Chz25KxO1ZgJ2kSrYyF1a8aEiImM6
         A7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DITB8TDqsPAGCEr6ydxFSW0ZRx1iCX6e3txUM+1mNSE=;
        b=lbdAYtndOMIb3VNZGpTa0OMMhp1oj/4nbVnGr7217LaMMS+QDWvh1lCgWrKNVOMVYp
         0W6CQeWhwzH4/rb4YkGCqTGg6uWt/xSEZNXW7vpdUh9SvGy2Zf4xTqatTb/rXbtG267D
         Cs81xMUYA4lhl0GA2QGDsJjWMFhK9GQzmaEiFvtA7az0TwRsKC1keDBOZpkvWGHxIAiZ
         KEj8TtZD+tOsIrpxL4kP64YUgn3zomK0t/1qHvATIRn/YIJWMBTH48lSN5Xd8APRhJyz
         +nc9x+lQtQKfyBbSf+25o1KYxCJbsLLL/9knJmGG5TNAS3YTkeYQuJjNnZNUrIM5N0fa
         ye8Q==
X-Gm-Message-State: APjAAAUDb6XvHySkZcUIBhSq0FheabAqRWsvdK2YBibPczeKEPauKJ/J
        Xkc5haqg+U4kGAexdtnHOWWZV6S6oDGn+wjHvA3YDdmF
X-Google-Smtp-Source: APXvYqzxwfi5wOa2zbiUUfC15vTSlB2UCFvZKKbnVvxPugtjkY0tcThTwXvNIUlkRx4WtNaN6Aq6gj0megLBl73MFWQ=
X-Received: by 2002:a7b:c403:: with SMTP id k3mr15763322wmi.89.1569797692496;
 Sun, 29 Sep 2019 15:54:52 -0700 (PDT)
MIME-Version: 1.0
From:   "David F." <df7729@gmail.com>
Date:   Sun, 29 Sep 2019 15:54:41 -0700
Message-ID: <CAGRSmLs+nyQ0pp_VPt36MxXDqumcyqLSR_vhkOqtFXir18puEA@mail.gmail.com>
Subject: Fix for fd0 and sr0 in /proc/partitions
To:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

So /proc/partitions can have floppy and optical drives on it.  For now
in config.c, load_partitions() function I added this after the major
number is obtained (just before minor strtoul() is performed):

        // ignore floppy and cdrom devices
        if (major==2 || major==11)
            continue;

Should probably be in the main line and back ported to some prior
versions.  I've gone with 4.1
