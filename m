Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DE747F11D
	for <lists+linux-raid@lfdr.de>; Fri, 24 Dec 2021 21:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344373AbhLXUtH (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 24 Dec 2021 15:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344365AbhLXUtG (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 24 Dec 2021 15:49:06 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA49EC061401
        for <linux-raid@vger.kernel.org>; Fri, 24 Dec 2021 12:49:05 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o30so3558912wms.4
        for <linux-raid@vger.kernel.org>; Fri, 24 Dec 2021 12:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=UtoF0r4yG8U/T8UOLxn8dacSd49m7zi2Qvhr7fGOaoo=;
        b=dJcJ37KsF8B34Zh/rrOhXMExIQYgNkiIwjSc4J2UbLu0msPrdfVQWl6H+P5+JRfjMe
         tJkim6Yky1i43UI+bUJ1FqRhaMMjm9Ln7bFYZROHySxMxeJ6iHpVnuF+ojepxhaTmWw0
         cMObdE6msqYmx25mtxI6NGc4hOpbLaf6J6S4XT8KQtd7Jxg4tzfgkAnsUQg1Wdl4jfL/
         sI3NoIFxvu5epe7yHTtz1N+ppaJSIOwwuIaL6+txN1L2xLFpoX/Dcp81+lFLczTba92b
         qVkaxAsyBQvNLwKjfp3ANdWjGBXExZpUIcMWZGyqTJn1ZYIEvhiEGAmiS2yT+7H6ubS7
         WXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=UtoF0r4yG8U/T8UOLxn8dacSd49m7zi2Qvhr7fGOaoo=;
        b=jOfNAFj0OOfHS4nNWV6YkYTjWlhlLcKqrATFKqKysWIXWnKZIf07OKRO9Mon8T22c+
         bS90OEij1R/J6omVWc8QtXcCx47gR4lxwowbxJUDIUKOPDGoq3vVW947wtowL+2cVB18
         O7KilqrScfdD31TuwzzEuyKUazeUFVarV+h/7TKc+0CHUFiSTpSuO4Bzr1cDzl7OepTH
         7D9mYvCXZnQ0hHAShvXWk2IYL1lJrkNyTx6YIGyw5UnzhPf2M9nD8PXtN+hGBB/BTYpa
         ll9W/Wy/+m4pLfue25g+PCMZVE+ORCVbUFAd2uyMza8QA9J2G45Ee9WeV2soZdZKFWQG
         jXzA==
X-Gm-Message-State: AOAM531hiBuoQdmU3/1bq9UMLyzcpPUWmQGuCiiPopslWCHIZag13D5k
        uK9YzCmyyOu5i/X2jQ8+aFw=
X-Google-Smtp-Source: ABdhPJzYV4LJsBTjggymjO458vfOxohdgBOqExA/JEiikVcvsTMQMil55Gjbkh5Qgt82zecizFIcxA==
X-Received: by 2002:a1c:9d55:: with SMTP id g82mr5879419wme.58.1640378944403;
        Fri, 24 Dec 2021 12:49:04 -0800 (PST)
Received: from [192.168.9.102] ([197.211.59.108])
        by smtp.gmail.com with ESMTPSA id o64sm8598249wme.28.2021.12.24.12.49.00
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 24 Dec 2021 12:49:04 -0800 (PST)
Message-ID: <61c63240.1c69fb81.1f8df.6de7@mx.google.com>
From:   Margaret Leung KO May-yeee <asabeabrakson@gmail.com>
X-Google-Original-From: Margaret Leung KO May-yeee
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?q?Gesch=C3=A4ftsvorschlag?=
To:     Recipients <Margaret@vger.kernel.org>
Date:   Fri, 24 Dec 2021 21:48:55 +0100
Reply-To: la67737777@gmail.com
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Bin Frau Margaret Leung Ich habe einen Gesch=E4ftsvorschlag f=FCr Sie, erre=
ichen Sie mich unter: la67737777@gmail.com

Margaret Leung
Managing Director of Chong Hing Bank
